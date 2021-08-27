//  TOPIC: DeFi 201    -->    VIDEO: "Program a Basic Flash Loan part 2"  //

pragma solidity ^0.5.0;

import "https://github.com/mrdavey/ez-flashloan/blob/remix/contracts/aave/FlashLoanReceiverBase.sol";
import "https://github.com/mrdavey/ez-flashloan/blob/remix/contracts/aave/ILendingPool.sol";
import "https://github.com/mrdavey/ez-flashloan/blob/remix/contracts/aave/ILendingPoolAddressesProvider.sol";


// test DAI ADDRESS: 0xFf795577d9AC8bD7D90Ee22b6C1703490b6512FD
// PROVIDER ADDRESS: 0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5
// 1000 test dai = 1000000000000000000000 when interacting with contract (Due to 18 decimal number)

contract basicFlashLoan is FlashLoanReceiverBase(address(0x506B0B2CF20FAA8f38a4E2B524EE43e1f4458Cc5)) {
  function flashLoan(uint256 newamount, address _token) external {
        // leaving params empty for now
    bytes memory _params = "0x0";
        // getting addresses for flash loan transactions
    address exchangeAddress = addressesProvider.getLendingPool();
    ILendingPool exchange = ILendingPool(exchangeAddress);
        // calling  flash loan function
    exchange.flashLoan(address(this), _token, newamount, _params);
  }

  function executeOperation(
    address _reserve,
    uint256 _amount,
    uint256 _fee,
    bytes calldata _params
  ) external {
    
// Add aditional functionality here. Whatever you want to do with the flash loan gets added here to be carried out in the same block as the loan repayment. 

        // flash loan is repaid with interest fee
    uint256 totalDebt = _amount.add(_fee);
    transferFundsBackToPoolInternal(_reserve, totalDebt);
  }
}
