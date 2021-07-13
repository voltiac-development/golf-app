export interface Friend {
    id: string,
    name: string,
    handicap: string,
    image: string,
    email: string
}

export interface FriendDatabase {
    id: string,
    friendId: string,
    connectionId: string
}

export interface FriendRequest {
    requestId: string,
    senderId: string,
    receiverId: string
}