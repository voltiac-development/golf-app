import { HTTPError } from "../errors/HTTPError.js";

export async function retrieveRecentRounds(uid: string): Promise<{data: object, error: HTTPError}> {
    return {data: [{date: Date.now(), }], error:null};
}

export async function createNewRound(players: string[], tees: number[], courseId: string, holeType: string): Promise<{data: object, error: HTTPError}> {
    console.log(players)
    return {data: null, error: new HTTPError(400, 'f')};
}