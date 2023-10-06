const zetaChain = require('zetachain-sdk');

async function stakeAndVote() {
    const contractAddress = '0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B'; 
    const contractAbi = [
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
        }
    ]; 

    const contract = new zetaChain.Contract(contractAddress, contractAbi);

    const stakeTx = await contract.methods.stake(1000).send({
        from: '0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B',
        gas: 150000,
        gasPrice: '30000000000000'
    });

    console.log('Stake transaction:', stakeTx);

    const voteTx = await contract.methods.vote(1).send({
        from: '0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B',
        gas: 150000,
        gasPrice: '30000000000000'
    });

    console.log('Vote transaction:', voteTx);
}

stakeAndVote();