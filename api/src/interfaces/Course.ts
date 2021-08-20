export interface Course {
    name: string,
    par: number,
    id: string,
    holes: number,
    image: string,
    roundTypes: RoundTypes[],
    teeBoxes: TeeBoxes,
    website: string,
    background: string,
}

export interface RoundTypes {
    roundTypeId: string,
    courseId: string,
    roundVariaton: string,
    startHole: number,
    endHole: number,
}

enum TeeBoxes {
    WHITE,
    BLUE,
    YELLOW,
    RED,
    ORANGE
}

export interface HoleLength {
    
}

export interface SiValues {
    id: string,
    courseId: string,
    hole: number,
    si: number,
    par: number,
}

export interface BusinessHours {
    id: string,
    courseId: string,
    day: string,
    open?: string,
    close?: string
}