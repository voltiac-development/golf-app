import { HTTPError } from "../errors/HTTPError";

export type roles = "USER" | "ADMIN";
export type genderType = "MALE" | "FEMALE" | "UNSPECIFIED";

export interface Account {
    id: string,
    email: string,
    name: string,
    password: string,
    created_on: number,
    last_access: number,
    verified: boolean,
    gender: genderType,
    role: roles,
    favcourse: string,
    handicap: number,
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

export interface ForgottenKey {
    keyId: string,
    uid: string,
    createdAt: number
}