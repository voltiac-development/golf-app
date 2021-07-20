import { createNewRound } from "../data/Round.js";
import { HTTPError } from "../errors/HTTPError.js";

export async function startNewRound(uid: string, course: string, tees: number[], players: string[], holeType: string): Promise<{data: object, error: HTTPError}> {
    players.unshift(uid);
    let { data, error } = await createNewRound(players, tees, course, holeType);

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