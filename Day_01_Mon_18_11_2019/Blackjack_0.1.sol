pragma solidity >=0.5.0 <0.7.0;
/** @author Sander Heij
    @title Blackjack game
*/
contract Blackjack {
    event Won(bool win)  ;   // declaring event
    /// Setup an intial amount for the bank, supplied during the creation of the contract.
    constructor() public payable {
    }
    uint maxDigits = 2;
    uint maxModulus = 10 ** maxDigits;
    uint totalInHand;
    uint dealer = 18;
    /** Perform the bet and pay out if you win
        @dev several temporary variables are created to make debugging easier
    */
    function betAndWin() public payable  { // returning value isn't easy to retreive
        address payable betPlacer = address(msg.sender);
        uint bet = msg.value;
        uint payout = bet * 2;
        uint balance = getBankBalance();
        require(bet > 0, "No money added to bet.");
        require(payout <= balance, "Not enough money in bank for this bet."); // bet has already been added to bank balance
        bool win = result() == false;
        if (win)
            betPlacer.transfer(payout);
        emit Won(win);// logging event
    }
    function result() public view returns(bool) {
      bool bet=false;
        if (totalInHand > dealer && totalInHand <= 21)
          bet=true;
        return bet;
    }
    /** Check the balance of the bank
        @return the balance
    */
    function getBankBalance() public view returns(uint256 ret) {
        return address(this).balance;
    }
  	/** Add the random card to the hand of the user
    */
  	function _addCard(uint _totalInHand) private view returns (uint) {
    }
    /** Draw a random card between 1 and 11
        @return a pseudo random card
    */
    function _getRandomCard(uint maxModulus) private view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(block.difficulty, block.coinbase, block.timestamp)));
        return rand % maxModulus;
    }
    /** Create a random card
    */
    function createRandomCard(uint _totalInHand) public {
        uint randCard = _getRandomCard(_totalInHand);
      	_addCard(_totalInHand);
    }
}
