pragma solidity ^0.6.2;
// inputs for the code 
//"1""alice""scissor""0x5B38Da6a701c568545dCfcB03FcB875f56beddC4""1000000000000000000"
//"2""Bob""stone""0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2""1000000000000000000"
// importing the erc20 contract to use in the program  
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v3.0.0/contracts/token/ERC20/ERC20.sol";

// contract that generates output for the rock paper sccissor and token transfer 
contract ROCKPAPERSCISSOR is ERC20{
  uint256 public _playernumer = 0; //each player is assigned a unique number  
  uint256 public _playerwinner; // show which player has won the game 
  address player1;    
  address player2;
  string move1;
  string  move2;
  address owner1;
  uint public amount1; //display the amount each user has to enter while playing the game that they win or loss 
  address owner2;
  uint public amount2; //display the amount each user has to enter while playing the game that they win or loss  
  uint public numTokens1 ;

  
  constructor(string memory name, string memory symbol) internal  ERC20(name, symbol) {
// minting 100 token which are convereted into (1*10*decimals) and assigened to the player
        _mint(msg.sender, 100 * 10**uint(decimals()));
    }
    
  // used to assign the player id to player          
 mapping(uint => Player) public player;  
    
// storing the player details in the structure 
    struct Player 
    {
    uint256  playernum1;
    string  playername;
    }
    
//enter the player name and details  
    function enterplayer(uint256  playernum1,string memory  playername,string memory move ,address players, uint256 numTokens1)public
    {   // checks the number of player that will play the game 
        if (_playernumer <= 2)
        _playernumer = playernum1;
        player[_playernumer] = Player (playernum1, playername );
        if (_playernumer == 1) { move1 = move;   player1 = players; } else { move2 = move ;  player2 = players;}
        if (_playernumer == 2) 
        {  
            _winner(move1,move2);
          
           if (_playerwinner == 1) {  transferFrom1(player2, player1,numTokens1); }  else { transferFrom1(player1,player2,numTokens1);  }
        }
    }
    
//function to decide the winner of the game of stone paper scissor 
        function _winner ( string memory _move1 ,string memory _move2 )internal returns(uint256) {
        if(keccak256(abi.encodePacked(_move1)) == keccak256(abi.encodePacked("scissor")) && keccak256(abi.encodePacked(_move2)) == keccak256(abi.encodePacked("paper")))
        { _playerwinner = 1 ;}
        else if ( keccak256(abi.encodePacked(_move1)) == keccak256(abi.encodePacked("paper")) && keccak256(abi.encodePacked(_move2)) == keccak256(abi.encodePacked("scissor")))
        { _playerwinner = 2; } 
       else if ( keccak256(abi.encodePacked( _move1)) ==  keccak256(abi.encodePacked("paper")) &&  keccak256(abi.encodePacked(_move2)) ==  keccak256(abi.encodePacked("stone")))
        { _playerwinner = 2; }
        else if ( keccak256(abi.encodePacked(_move1)) == keccak256(abi.encodePacked("paper")) && keccak256(abi.encodePacked (_move2)) ==  keccak256(abi.encodePacked("stone")))
        { _playerwinner = 2; }
        else if ( keccak256(abi.encodePacked( _move1)) == keccak256(abi.encodePacked("stone")) && keccak256(abi.encodePacked(_move2)) == keccak256(abi.encodePacked("paper")))
        { _playerwinner = 1; }
        else if (keccak256(abi.encodePacked( _move1)) == keccak256(abi.encodePacked("scissor")) && keccak256(abi.encodePacked(_move2 ))== keccak256(abi.encodePacked("stone")))
        { _playerwinner = 2; }
         else if ( keccak256(abi.encodePacked(_move1)) == keccak256(abi.encodePacked("stone")) && keccak256(abi.encodePacked(move2)) == keccak256(abi.encodePacked("scissor")))
         { _playerwinner = 1 ; }
         return _playerwinner;
                 }

//function responsible for transfering token from one account to another account 
         function transferFrom1(address owner, address buyer,uint256 numTokens) internal returns (bool)
        {   // transfer the token fromn one account to another account  
            emit Transfer(buyer, owner, numTokens);            
            //transferFrom(owner, buyer, numTokens);
                        //return true;
                                
        }
}