import { HTTPError } from "../errors/HTTPError.js";
import { Friend, FriendDatabase } from "../interfaces/Friend.js";
import { sql } from "./knex.js";

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