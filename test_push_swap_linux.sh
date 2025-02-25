#!/bin/bash

print_header() {
    echo "----------------------------------------"
    echo "$1"
    echo "----------------------------------------"
}

test_checker() {
    print_header "CHECKER PROGRAM TESTS"
    
    echo "Test 1: Already sorted list"
    ./push_swap 0 1 2 | ./checker_linux 0 1 2
    
    echo -e "\nTest 2: Manual operations test"
    echo "Enter these operations:"
    echo "pb, ra, pb, ra, sa, ra, pa, pa"
    echo "Press Ctrl+D when done"
    echo -e "\nStarting checker..."
    result=$(./checker_linux 0 9 1 8 2)
    echo -e "\nResult: $result"
    sleep 1
}

test_identity() {
    print_header "IDENTITY TESTS"
    
    echo "Test 1: Single number"
    ./push_swap 42 | wc -l
	sleep 1
    
    echo -e "\nTest 2: Four numbers sorted"
    ./push_swap 0 1 2 3 | wc -l
	sleep 1
    
    echo -e "\nTest 3: Ten numbers sorted"
    ./push_swap 0 1 2 3 4 5 6 7 8 9 | wc -l
	sleep 1
}

test_simple() {
    print_header "SIMPLE VERSION TESTS"
    
    echo "Test 1: Three numbers"
    ARG="2 1 0"
    echo "Operations:"
    ops=$(./push_swap $ARG | wc -l)
    echo $ops
    echo "Result:"
    result=$(./push_swap $ARG | ./checker_linux $ARG)
    echo $result
    if [ $ops -ne 2 ] && [ $ops -ne 3 ]; then
        echo "Grade: Failure 💀 (must be exactly 2 or 3 operations)"
    fi
    sleep 1
    
    echo -e "\nTest 2: Five numbers (first set)"
    ARG="1 5 2 4 3"
    echo "Operations:"
    ops=$(./push_swap $ARG | wc -l)
    echo $ops
    echo "Result:"
    result=$(./push_swap $ARG | ./checker_linux $ARG)
    echo $result
    if [ $ops -gt 12 ]; then
        echo "Grade: Failure 💀 (more than 12 operations)"
    fi
    sleep 1
    
    echo -e "\nTest 3: Five numbers (second set)"
    ARG="6 5 7 4 9"
    echo "Operations:"
    ops=$(./push_swap $ARG | wc -l)
    echo $ops
    echo "Result:"
    result=$(./push_swap $ARG | ./checker_linux $ARG)
    echo $result
    if [ $ops -gt 12 ]; then
        echo "Grade: Failure 💀 (more than 12 operations)"
    fi
    sleep 1
}

grade_100() {
    local ops=$1
    if [ $ops -lt 700 ]; then
        echo "Grade: S 🌟"
    elif [ $ops -lt 900 ]; then
        echo "Grade: A 👍"
    elif [ $ops -lt 1100 ]; then
        echo "Grade: B 👌"
    elif [ $ops -lt 1300 ]; then
        echo "Grade: C 😕"
    elif [ $ops -lt 1500 ]; then
        echo "Grade: D 😬"
    else
        echo "Grade: Failure 💀"
    fi
}

grade_500() {
    local ops=$1
    if [ $ops -lt 5500 ]; then
        echo "Grade: S 🌟"
    elif [ $ops -lt 7000 ]; then
        echo "Grade: A 👍"
    elif [ $ops -lt 8500 ]; then
        echo "Grade: B 👌"
    elif [ $ops -lt 10000 ]; then
        echo "Grade: C 😕"
    elif [ $ops -lt 11500 ]; then
        echo "Grade: D 😬"
    else
        echo "Grade: Failure 💀"
    fi
}

test_middle() {
    print_header "MIDDLE VERSION TEST (100 numbers)"
    
    for i in {1..3}; do
        echo "Test $i:"
        ARG=$(python3 -c "
import random
nums = random.sample(range(-50000, 50000), 100)
print(' '.join(map(str, nums)))
")
        ops=$(./push_swap $ARG | wc -l)
        result=$(./push_swap $ARG | ./checker_linux $ARG)
        echo "Operations: $ops"
        echo "Result: $result"
        grade_100 $ops
        echo "-------------------"
		sleep 1
    done
}

test_advanced() {
    print_header "ADVANCED VERSION TEST (500 numbers)"
    
    for i in {1..3}; do
        echo "Test $i:"
        ARG=$(python3 -c "
import random
nums = random.sample(range(-50000, 50000), 500)
print(' '.join(map(str, nums)))
")
        ops=$(./push_swap $ARG | wc -l)
        result=$(./push_swap $ARG | ./checker_linux $ARG)
        echo "Operations: $ops"
        echo "Result: $result"
        grade_500 $ops
        echo "-------------------"
		sleep 1
    done
}

# Run all tests
test_checker
test_identity
test_simple
test_middle
test_advanced
