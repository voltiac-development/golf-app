import { fetchUserData } from "../data/Authentication.js";
import { addFriend, fetchAllFriends, fetchAllRequests, getRequestFromId, getRequestFromIds, removeFriend, removeRequest, retrieveFriend, sendNewRequest } from "../data/Friend.js";
import { retrieveRecentRounds } from "../data/Round.js";
import { HTTPError } from "../errors/HTTPError.js";

export async function getAllFriends(uid: string): Promise<{data: object, error: HTTPError}> {
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

export async function getAllRequests(uid: string): Promise<{data: object, error: HTTPError}> {
    const { data, error } = await fetchAllRequests(uid);

    console.log(data, error, uid)
    let response = {
        data: null,
        error: null
    }

    if (error) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = {'requests': data};

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
        friend['rounds'] = roundsData.data

        response.data = {'friend': friend};
    }
    else
        response.error = new HTTPError(404, "U bent niet bevriend met deze persoon.");

    return response;
}

export async function requestNewFriend(uid: string, friendEmail: string): Promise<{data: object, error: HTTPError}> {
    if (friendEmail == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}
    
    let friendData = await fetchUserData(friendEmail);
    if(friendData.error)
        return {data: null, error: new HTTPError(501, friendData.error)};
    let friendId = friendData.data.id;
    const { data, e } = await getRequestFromIds(uid, friendId);
    
    if(data)
        return {data:null, error: new HTTPError(401, "Al een verzoek verstuurd.")}
    
    let friendUserData = await getSpecificFriend(uid, friendId);
    if(friendUserData.error)
        return {data: null, error: new HTTPError(500, friendUserData.error)};
    
    if(friendUserData.data)
        return {data:null, error: new HTTPError(401, "U bent al bevriend met deze gebruiker.")}
    
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

export async function acceptRequest(uid: string, friendId: string): Promise<{data: object, error: HTTPError}> {
    if (friendId == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}

    let result = null;
    let response = {
        data: null,
        error: null
    }
    
    var { data, e } = await getRequestFromIds(uid, friendId);
    if (e) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
        return response;
    }
    else {
        e = (await addFriend(data.senderId, data.receiverId)).error;
        if (e) {
            response.error = new HTTPError(404, "Er is een probleem met de database.");
        }
        e = (await addFriend(data.receiverId, data.senderId)).error;
        if (e) {
            response.error = new HTTPError(404, "Er is een probleem met de database.");
        }
        e = (await removeRequest(data.requestId)).error;
        if (e) {
            response.error = new HTTPError(404, "Er is een probleem met de database.");
        }
        result = await retrieveFriend(data.receiverId, data.senderId);
    }


    if (e) {
        response.error = new HTTPError(404, "Er is een probleem met de database.");
    }else
        response.data = result.data;

    return response;
}

export async function declineRequest(uid: string, friendId: string): Promise<{data: object, error: HTTPError}> {
    if (friendId == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}
    
    const { data, e } = await getRequestFromIds(uid, friendId);
    if(e){
        return {data: null, error: new HTTPError(404, "Verzoek bestaat niet.")}
    }
    let error = (await removeRequest(data.requestId)).error;

    if(error){
        return {data: null, error: new HTTPError(500, 'Er is een probleem met de database.')}
    }

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

export async function deleteFriend(uid: string, friendId: string): Promise<{data: object, error: HTTPError}> {
    if (friendId == null || uid == null)
        return {data: null, error: new HTTPError(401, "Verkeerde aanvraag.")}
    
    const { error } = await removeFriend(uid, friendId);

    if(error){
        return {data: null, error: new HTTPError(500, 'Er is een probleem met de database.')}
    }

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