import { sql } from "./knex.js";

import { RoundInfo } from "../interfaces/Round.js";
import { v4 } from 'uuid';

export async function retrieveRecentRounds(uid: string): Promise<{data: object, error: Error}> {
    let roundData = null, error = null;

    try {
        roundData = await sql<RoundInfo>('rounds').select('rounds.*', 'courses.image', 'courses.name', 'roundTypes.*')
        .where({playerOne: uid}).orWhere({playerTwo: uid}).orWhere({playerThree: uid}).orWhere({playerFour: uid}).innerJoin('courses', 'rounds.courseId', 'courses.id')
        .innerJoin('roundTypes', 'rounds.holeTypeId', 'roundTypes.roundTypeId');
    } catch (e) {
        error = e;
    }
    return {
        data: roundData,
        error
    }
}

export async function createNewRound(players: string[], tees: number[], courseId: string, holeType: string, qualifying: boolean, phcs: number[]): Promise<{data: string, error: Error}> {
    let roundId = v4();
    let roundData = null, error = null;

    try {
        roundData = await sql<RoundInfo>('rounds').insert({roundId: roundId, courseId: courseId, holeTypeId: holeType, playerOne: players[0], playerTwo: players[1], playerThree: players[2],
            playerFour: players[3], teeOne: tees[0], teeTwo: tees[1], teeThree: tees[2], teeFour: tees[3], qualifying: qualifying ? 1 : 0, phcOne: phcs[0], phcTwo: phcs[1], phcThree: phcs[2], phcFour: phcs[3]})
    } catch (e) {
        error = e;
    }
    return {
        data: roundId,
        error
    }
}

export async function fetchSpecificRound(roundId: string): Promise<{data: object, error: Error}> {
    let roundData = null, error = null;

    try {
        roundData = await sql<RoundInfo>('rounds').select('a.name as playerOne', 'a.id as oneId', 'a.handicap as oneHandicap', 'ac.name as playerTwo', 
        'ac.handicap as twoHandicap', 'ac.id as twoId', 'acc.name as playerThree', 'acc.handicap as threeHandicap',
        'acc.id as threeId', 'acco.name as playerFour', 'acco.id as fourId', 'acco.handicap as fourHandicap', 'teeOne', 'teeTwo', 'teeThree', 'teeFour', 'holeTypeId', 
        'c.name as courseName', 'c.id as courseId', 'startsAt', 'qualifying', 'roundTypes.roundVariation', 'roundTypes.startHole', 'roundTypes.endHole', 'phcOne', 'phcTwo', 'phcThree', 'phcFour')
        .where({roundId: roundId})
        .leftJoin('accounts as a','rounds.playerOne', 'a.id')
        .leftJoin('accounts as ac', 'rounds.playerTwo', 'ac.id')
        .leftJoin('accounts as acc', 'rounds.playerThree', 'acc.id')
        .leftJoin('accounts as acco', 'rounds.playerFour', 'acco.id')
        .leftJoin('courses as c', 'rounds.courseId', 'c.id')
        .innerJoin('roundTypes', 'rounds.holeTypeId', 'roundTypes.roundTypeId');
    } catch (e) {
        error = e;
    }
    return {
        data: roundData,
        error
    }
}

export async function retrieveRecentCourseRounds(uid: string, courseId: string): Promise<{data: object, error: Error}> {
    let roundData = null, error = null;

    try {
        roundData = await sql<RoundInfo>('rounds').select('*').where({playerOne: uid}).andWhere({courseId: courseId}).orWhere({playerTwo: uid}).andWhere({courseId: courseId}).orWhere({playerThree: uid}).andWhere({courseId: courseId}).orWhere({playerFour: uid}).andWhere({courseId: courseId})
    } catch (e) {
        error = e;
    }
    return {
        data: roundData,
        error
    }
}