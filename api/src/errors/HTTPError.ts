export class HTTPError extends Error {
    statusCode: number;
    message: string;

    constructor(StatusCode, Message) {
        super(StatusCode + ": " + Message);
        this.statusCode = StatusCode;
        this.message = Message;
    }

    getStatusCode() {
        return this.statusCode;
    }

    getErrorMessage() {
        return {
            error: this.message
        }
    }
}