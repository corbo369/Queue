// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

/**
 * @dev Basic implementation of a queue to store uint256. This library provides funcitonality for construction
 * of a new queue, enqueing, dequeuing, and popping. Also the queue automatically expands upon reaching max 
 * capacity. 
 */
library QueueLibrary {
    
    /**
     * @dev Struct for a basic queue of type uint256. Contains 'elements' which stores the data, 'capacity'
     * which is the length of elements, 'count' a live of count of number of elements in the queue, 'front'
     * is the index of the front element of the queue.
     */
    struct Queue {
        uint256[] elements;
        uint256 capacity;
        uint256 count;
        uint256 front;
    }


    function NewQueue() public pure returns(Queue memory){
        uint256[] memory temp = new uint256[](5);
        Queue memory newQueue = Queue(
            {
                elements: temp,
                capacity: temp.length,
                count: 0,
                front: 0
            }
        );
        return newQueue;
    }


    function Enqueue(Queue memory q, uint256 x) public pure returns(Queue memory) {
        if (q.count == q.capacity) {
            uint256[] memory temp = new uint256[](q.capacity * 2);
            for(uint256 i; i < q.capacity; i++) {
                temp[i] = q.elements[i];
            }
            q.elements = temp;
            q.capacity = temp.length;
        }
        if ((q.front + q.count) <= q.capacity) {
            q.elements[q.front + q.count] = x;
            q.count++;
        }
        else {
            q.elements[(q.front + q.count) - q.capacity] = x;
            q.count++;
        }
        return q;
    }


    function Peek(Queue memory q) public pure returns(uint256) {
        require(q.count != 0, "Queue is empty");
        return(q.elements[q.front]);
    }


    function Dequeue(Queue memory q) public pure returns(Queue memory) {
        require(q.count != 0, "Queue is empty");
        q.count--;
        q.elements[q.front] = 0;

        if (q.front + 1 > q.capacity) {
            q.front = 0;
            return q;
        }
        else {
            q.front++;
            return q;
        }
    }
}
