export interface Friend {
    id: string,
    name: string,
    handicap: string,
    image: string, 
}

export interface FriendDatabase {
    id: string,
    friendId: string,
    connectionId: string
}