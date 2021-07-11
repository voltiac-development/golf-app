import { HTTPError } from "../errors/HTTPError.js";
import { Friend, FriendDatabase, FriendRequest } from "../interfaces/Friend.js";
import { sql } from "./knex.js";
import { v4 } from 'uuid';

export async function fetchAllFriends(uid: string): Promise<{data: [Friend], error: HTTPError}> {
    let friendData = null, error = null;

    try {
        friendData = await sql('friends').select('accounts.id', 'accounts.name', 'accounts.handicap', 'accounts.image').where({'friends.id': uid}).innerJoin('accounts', 'friends.friendId', '=', 'accounts.id')
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

export async function acceptRequest(requestId: string): Promise<{data: Friend, error: HTTPError}> {
    let requestData = null, error = null, result = null;

    try {
        requestData = await sql<FriendRequest>('friendrequests').select('*').where({'requestId': requestId});
        if(requestData.length > 0){
            let data = requestData[0], connId = v4();
            await sql<FriendDatabase>('friends').insert({'id': data.senderId, 'friendId': data.receiverId, connectionId: connId});
            await sql<FriendDatabase>('friends').insert({'id': data.receiverId, 'friendId': data.senderId, connectionId: v4()});
            await sql<FriendRequest>('friendrequests').delete().where({'requestId': requestId});
            result = await sql('friends').select('accounts.id', 'accounts.name', 'accounts.handicap', 'accounts.image').where({'friends.connectionId': connId}).innerJoin('accounts', 'friends.friendId', '=', 'accounts.id')
        }
        else error = new HTTPError(400, "Verzoek is niet gevonden.")
        
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        data: result,
        error
    }
}

export async function rejectRequest(requestId: string): Promise<{error: HTTPError}> {
    let requestData = null, error = null;

    try {
        requestData = await sql<FriendRequest>('friendrequests').select('*').where({'requestId': requestId});
        if(requestData.length > 0){
            let data = requestData[0];
            await sql<FriendRequest>('friendrequests').delete().where({'requestId': requestId});
        }
        else error = new HTTPError(400, "Verzoek is niet gevonden.")
        
    } catch (e) {
        error = new HTTPError(500, "Probleem met de server.");
    }
    return {
        error
    }
}