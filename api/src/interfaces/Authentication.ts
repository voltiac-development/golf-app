import { HTTPError } from "../errors/HTTPError";

export type roles = "USER" | "ADMIN";

export interface Account {
    id: string,
    email: string,
    name: string,
    password: string,
    created_on: number,
    last_access: number,
    verified: boolean,
    phone_number: string,
    role: roles,
}

export interface LoginResponse {
    data: {
        jwtToken: String,
        userData: object
    },
    error: HTTPError
}

export interface RegisterResponse {
    data: Object,
    error: HTTPError
}