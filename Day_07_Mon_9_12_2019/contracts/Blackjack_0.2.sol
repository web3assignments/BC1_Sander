pragma solidity >=0.5.0 <0.7.0;
/** @author Sander Heij
    @title Blackjack game
*/
contract Blackjack {
    event Won(bool win)  ;   // declaring event
    /// Setup an intial amount for the bank, supplied during the creation of the contract.
    constructor() public payable {
    }
    uint totalInHand;
    uint randCardCopy;
    uint dealer = 18;
    event WinorLose(uint indexed win, bytes32 bet);

    mapping(address => uint) public player;

    function update(uint newPlayer) public {
        player[msg.sender] = newPlayer;
    }

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
        bool win = _result() == false;
        if (win)
            betPlacer.transfer(payout);
        emit Won(win);// logging event
    }
    function _result() private view returns(bool) {
      bool win = false;
        if (totalInHand > dealer && totalInHand <= 21)
          win = true;
        return win;
    }
    /** Check the balance of the bank
        @return the balance
    */
    function getBankBalance() public view returns(uint256 ret) {
        return address(this).balance;
    }
  	/** Add the random card to the hand of the user
    */
  	function showHand() public view returns (uint) {
  	    return totalInHand;
    }
    /** Draw a random card between 1 and 11
        @return a pseudo random card
    */
    function _getRandomCard() private view returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(block.difficulty, block.coinbase, block.timestamp)));
        return rand % 11;
    }
    /** Create and add a random card
    */
    function createRandomCard() public returns (uint) {
        uint randCard = _getRandomCard();
        //add the card to the hand
        totalInHand = totalInHand + randCard;
        return totalInHand;
    }
}
