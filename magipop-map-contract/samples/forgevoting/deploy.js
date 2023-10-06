const zetaChain = require('zetachain-sdk');

async function deployContract() {
    const contract = new zetaChain.Contract({
        code: `0x608060405234801561001057600080fd5b5060db8061001f6000396000f3fe608060405260043610603f5760003560e01c806360fe47b11460445780636d4ce63c146062575b600080fd5b604a6068575b005b348015606e57600080fd5b506075608f565b6040518082815260200191505060405180910390f35b6000805490509056fea26469706673582212209c3a2bbd4254d88e6e37d6a77f581c76a6c0e1b64d9e6e745d3b316c4ef738a464736f6c63430008040033`, 
        abi: [
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "amount",
                        "type": "uint256"
                    }
                ],
                "name": "stake",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    {
                        "name": "proposal",
                        "type": "uint256"
                    }
                ],
                "name": "vote",
                "outputs": [],
                "payable": false,
                "stateMutability": "nonpayable",
                "type": "function"
            },
            {
                "constant": true,
                "inputs": [{ "name": "owner", "type": "address" }],
                "name": "balanceOf",
                "outputs": [{ "name": "balance", "type": "uint256" }],
                "type": "function"
            },
            {
                "constant": false,
                "inputs": [
                    { "name": "to", "type": "address" },
                    { "name": "value", "type": "uint256" }
                ],
                "name": "transfer",
                "outputs": [{ "name": "success", "type": "bool" }],
                "type": "function"
            }
        ]; 
    });
}

deployContract();