import { createNewRound, fetchSpecificRound, retrieveRecentCourseRounds, retrieveRecentRounds } from "../data/Round.js";
import { HTTPError } from "../errors/HTTPError.js";
import { RoundInfo } from "../interfaces/Round.js";

export async function startNewRound(uid: string, course: string, tees: number[], players: string[], holeType: string, qualifying: boolean): Promise<{data: object, error: HTTPError}> {
    players.unshift(uid);
    //* REMOVE THIS FOR PRODUCTION AFTER TEST
    if(course != "ad039a90-857d-4a9b-ada7-f7458ac3deb3")
        return {data: null, error: new HTTPError(400, 'Deze golfbaan is uitgeschakeld.')};
    let phcs = await getPlayingHandicaps(players);
    console.log(players.length);
    if(players[1] == null && players[2] == null && players[3] == null)
        qualifying = false;
    let { data, error } = await createNewRound(players, tees, course, holeType, qualifying, phcs);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        console.log(error)
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'msg': data};

    return response;
}

export async function getRecentRounds(uid: string): Promise<{data: object[], error: HTTPError}> {
    let { data, error } = await retrieveRecentRounds(uid);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'rounds': data};

    return response;
}

export async function getSpecificRound(uid: string, roundId: string): Promise<{data: object, error: HTTPError}> {
    let { data, error } = await fetchSpecificRound(roundId);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else{
        let roundIsOwned = false;
        response.data = data[0];
        if(response.data.oneId == uid){
            response.data.key = "playerOne";
            roundIsOwned = true;
        }
        else if(response.data.twoId == uid){
            response.data.key = "playerTwo";
            roundIsOwned = true;
        }
        else if(response.data.threeId == uid){
            response.data.key = "playerThree";
            roundIsOwned = true;
        }
        else if(response.data.fourId == uid){
            response.data.key = "playerFour";
            roundIsOwned = true;
        }
    }

    return response;
}

export async function getSpecificCourseRounds(uid: string, courseId: string): Promise<{data: object, error: HTTPError}> {
    let { data, error } = await retrieveRecentCourseRounds(uid, courseId);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else{
        response.data = data;
    }

    return response;
}

async function getPlayingHandicaps(players: string[]) {
    return [0, 1, null, null]
}