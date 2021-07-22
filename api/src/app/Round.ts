import { createNewRound, fetchSpecificRound, retrieveRecentRounds } from "../data/Round.js";
import { HTTPError } from "../errors/HTTPError.js";
import { RoundInfo } from "../interfaces/Round.js";

export async function startNewRound(uid: string, course: string, tees: number[], players: string[], holeType: string, qualifying: boolean): Promise<{data: object, error: HTTPError}> {
    players.unshift(uid);
    let { data, error } = await createNewRound(players, tees, course, holeType, qualifying);

    let response = {
        data: null,
        error: null
    }

    if (error) {
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