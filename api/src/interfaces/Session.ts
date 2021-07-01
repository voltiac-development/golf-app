export interface JWTToken {
    exp: number,
    iat: number,
    jti: string,
    iss: string,
    sub: string,
    auth_level: string,
}