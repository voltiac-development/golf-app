import { fetchAllFriends, getRequestFromIds, sendNewRequest } from "../data/Friend.js";
import { retrieveRecentRounds } from "../data/Round.js";
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

export async function getAllRequests(uid: string): Promise<{data: object, error: HTTPError}> {
    const { data, error } = await fetchAllFriends(uid);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'friends': data};

    return response;
}

export async function getSpecificFriend(uid: string, friendId: string): Promise<{data: object, error: HTTPError}> {
    if (friendId == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}
    const { data, error } = await fetchAllFriends(uid);
    let friend = data.find((f) => f.id == friendId)
    let roundsData = await retrieveRecentRounds(uid);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else if(friend != null && roundsData.error == null){
        data['rounds'] = roundsData.data

        response.data = {'friend': data};
    }
    else
        response.error = new HTTPError(404, "U bent niet bevriend met deze persoon.");

    return response;
}

export async function requestNewFriend(uid: string, friendId: string): Promise<{data: object, error: HTTPError}> {
    if (friendId == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}
    
    const { data, e } = await getRequestFromIds(uid, friendId);

    if(data)
        return {data:null, error: new HTTPError(401, "Al een verzoek verstuurd.")}
    
    const { error } = await sendNewRequest(uid, friendId);

    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = "SUCCESS";

    return response;
}