import { sql } from "./knex.js";

import { RoundInfo } from "../interfaces/Round.js";
import { v4 } from 'uuid';

export async function retrieveRecentRounds(uid: string): Promise<{data: object, error: Error}> {
    return {data: [{date: Date.now(), }], error:null};
}

export async function createNewRound(players: string[], tees: number[], courseId: string, holeType: string): Promise<{data: string, error: Error}> {
    let roundId = v4();
    let roundData = null, error = null;

    try {
        roundData = await sql<RoundInfo>('rounds').insert({roundId: roundId, courseId: courseId, holeTypeId: holeType, playerOne: players[0], playerTwo: players[1], playerThree: players[2],
            playerFour: players[3], teeOne: tees[0], teeTwo: tees[1], teeThree: tees[2], teeFour: tees[3]})
    } catch (e) {
        error = e;
    }
    return {
        data: roundId,
        error
    }
}