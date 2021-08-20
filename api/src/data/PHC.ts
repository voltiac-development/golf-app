import { HTTPError } from "../errors/HTTPError.js";
import { PlayingHandicap } from "../interfaces/PHC.js";
import { sql } from "./knex.js";

export async function fetchPlayingHandicap(roundVariation: string, teebox: number, handicap: number, gender: number): Promise<{data: object, error: HTTPError}> {
    let playingHcpData = null, error = null;
    try {
        playingHcpData = await sql<PlayingHandicap>('playingHandicap').select('*')
        .where({roundVariationId: roundVariation, teebox: teebox, gender: gender}).andWhere('lowerHC', '<=', handicap).andWhere('upperHC', '>=', handicap);
        if(playingHcpData.length > 0){
            playingHcpData = playingHcpData[0];
        }else{
            return {data: null, error: new HTTPError(404, "PHC niet gevonden.")}
        }
    } catch (e) {
        error = e;
    }
    return {
        data: playingHcpData,
        error
    }
}