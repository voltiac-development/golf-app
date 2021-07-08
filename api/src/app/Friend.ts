import { fetchAllFriends } from "../data/Friend.js";
import { HTTPError } from "../errors/HTTPError.js";

export async function getAllFriends(uid: string): Promise<{data: object, error: HTTPError}> {
    const { data, error } = await fetchAllFriends(uid);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        console.log(error)
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'friends': data};

    return response;
}