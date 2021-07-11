import { HTTPError } from "../errors/HTTPError.js";

export async function retrieveRecentRounds(uid: string): Promise<{data: object, error: HTTPError}> {
    return {data: [{date: Date.now(), }], error:null};
}