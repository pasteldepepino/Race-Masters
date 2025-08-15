#!/bin/bash

your_lane=2
score=0
game_over=0
enemy_pos=1
enemy_lane=$((RANDOM % 3 + 1))
enemy_speed=0.05


clear

draw_road() {
    clear
    echo -e "SCORE: $score"
    echo ""
    
    for ((i=1; i<=20; i++)); do
        lane1=" | | "
        lane2=" | | "
        lane3=" | | "
        
        if [[ $i -eq $enemy_pos ]]; then
            case $enemy_lane in
                1) lane1=" |X| ";;
                2) lane2=" |X| ";;
                3) lane3=" |X| ";;
            esac
        fi
        
        echo "$lane1$lane2$lane3"
        
        if [[ $i -eq 19 ]]; then
            case $your_lane in
                1) echo " |O|  | |  | | ";;
                2) echo " | |  |O|  | | ";;
                3) echo " | |  | |  |O| ";;
            esac
        fi
    done
}

while [[ $game_over -eq 0 ]]; do
    draw_road
    
    ((enemy_pos++))
    
    if [[ $enemy_pos -eq 19 && $enemy_lane -eq $your_lane ]]; then
        game_over=1
        echo -e "CRASH! GAME OVER!"
        echo "Final Score: $score"
        break
    fi
    
    if [[ $enemy_pos -gt 19 ]]; then
        enemy_pos=1
        enemy_lane=$((RANDOM % 3 + 1))
        ((score++))
    fi
    
    read -t $enemy_speed -n 1 -s key
    
    case "$key" in
        z) [[ $your_lane -gt 1 ]] && ((your_lane--));;
        x) [[ $your_lane -lt 3 ]] && ((your_lane++));;
        q) game_over=1;;
    esac
done