// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {
    address public owner ;
    address payable[] players ;
    uint public contestId ;
    mapping  (uint => address) public contestHistory ;

    constructor(){
        owner = msg.sender ;
        contestId = 1 ;
    }

    function enterContest() public payable {
        require(msg.value > 100000 wei, "Insufficient fund") ;
        players.push(payable(msg.sender)) ;
    }

    function getPlayers() public view returns(address payable[] memory){
        
        return players ;
    }

    function getRandomNumber() public view returns(uint) {
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)));
    }

    function pickWinner() public payable {
        uint index = getRandomNumber() % players.length ;
        players[index].transfer(address(this).balance) ;

        contestHistory[contestId] = players[index];
        contestId++ ;

        players = new address payable[](0) ;


    }

}