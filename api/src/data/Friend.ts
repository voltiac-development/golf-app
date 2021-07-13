import { HTTPError } from "../errors/HTTPError.js";
import { Friend, FriendDatabase, FriendRequest } from "../interfaces/Friend.js";
import { sql } from "./knex.js";
import { v4 } from 'uuid';

export async function fetchAllFriends(uid: string): Promise<{data: [Friend], error: HTTPError}> {
    let friendData = null, error = null;

    try {
        friendData = await sql('friends').select('accounts.id', 'accounts.name', 'accounts.handicap', 'accounts.image', 'accounts.email').where({'friends.id': uid}).innerJoin('accounts', 'friends.friendId', '=', 'accounts.id')
    } catch (e) {
        error = e;
    }
    return {
        data: friendData,
        error
    }
}

export async function getRequestFromIds(uid: string, friendId: string): Promise<{data: FriendRequest, e: HTTPError}> {
    let requestData = null, e = null, result = null;

    try {
        requestData = await sql<FriendRequest>('friendrequests').select('*').where({'senderId': uid, 'receiverId': friendId}).or.where({'receiverId': uid, 'senderId': friendId})
        if (requestData.length > 0){
            result = requestData[0];
        }else{
            result = [];
        }
        
    } catch (error) {
        e = new HTTPError(500, "Probleem met de server.");
    }
    return {
        data: result,
        e
    }
}

export async function sendNewRequest(uid: string, friendId: string): Promise<{error: HTTPError}> {
    let requestData = null, error = null

    try {
        requestData = await sql<FriendRequest>('friendrequests').insert({'receiverId': friendId, 'senderId': uid, 'requestId': v4()});
        if(requestData.length != 1)
            error = new HTTPError(400, "Verkeerde aanvraag.");
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        error
    }
}

export async function addFriend(uid: string, friendId: string): Promise<{data: String, error: HTTPError}> {
    let error = null

    try {
        var connId = v4();
        await sql<FriendDatabase>('friends').insert({'id': uid, 'friendId': friendId, connectionId: connId});
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        data: connId,
        error
    }
}

export async function removeRequest(requestId: string): Promise<{error: HTTPError}> {
    let error = null

    try {
        await sql<FriendRequest>('friendrequests').delete().where({'requestId': requestId});
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        error
    }
}

export async function getRequestFromId(requestId: string): Promise<{data: FriendRequest, error: HTTPError}> {
    let requestData = null, error = null, data = null;

    try {
        requestData = await sql<FriendRequest>('friendrequests').select('*').where({'requestId': requestId});
        if(requestData.length > 0){
            data = requestData[0];
        }
        else error = new HTTPError(400, "Verzoek is niet gevonden.")
        
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        data,
        error
    }
}

export async function retrieveFriend(uid: string, friendId: string): Promise<{data: FriendRequest, error: HTTPError}> {
    let requestData = null, error = null, data = null;

    try {
        requestData = await sql('friends').select('accounts.id', 'accounts.name', 'accounts.handicap', 'accounts.image').where({'friends.id': uid, 'friends.friendId': friendId}).innerJoin('accounts', 'friends.friendId', '=', 'accounts.id')
        if(requestData.length > 0){
            data = requestData[0];
        }
        else error = new HTTPError(400, "Verzoek is niet gevonden.")
        
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        data,
        error
    }
}

export async function fetchAllRequests(uid: string): Promise<{data: [object], error: HTTPError}> {
    let requestData = null, error = null;

    try {
        requestData = await sql('friendrequests').select('accounts.id', 'accounts.name', 'accounts.handicap', 'accounts.image', 'accounts.email').where({'friendrequests.receiverId': uid}).innerJoin('accounts', 'friendrequests.senderId', '=', 'accounts.id')
    } catch (e) {
        error = e;
    }
    return {
        data: requestData,
        error
    }
}