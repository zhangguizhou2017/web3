import {
    ethers
} from 'ethers';

const MY_INFURA_SEPOLIA_RPC = 'https://sepolia.infura.io/v3/4013d92584b14f69a0128110b7c76be4';
const provider = new ethers.JsonRpcProvider(MY_INFURA_SEPOLIA_RPC);

const privateKey = '0xe6b2f9f43f196f1c0212400701538a1709a5ee0c580ca74816bc2e036deb1fcf';
const wallet = new ethers.Wallet(privateKey, provider);

// WETH的ABI
const abiWETH = [
    "function balanceOf(address) public view returns(uint)",
    "function deposit() public payable",
    "function transfer(address, uint) public returns (bool)",
    "function withdraw(uint) public",
];
// WETH合约地址（Sepolia测试网）
const addressWETH = '0xfFf9976782d46CC05630D1f6eBAb18b2324d6B14' // WETH Contract on Sepolia

// 声明可写合约
const contractWETH = new ethers.Contract(addressWETH, abiWETH, wallet)




const address = await wallet.getAddress()
// 读取WETH合约的链上信息（WETH abi）
console.log("\n1. 读取WETH余额")
const balanceWETH = await contractWETH.balanceOf(address)
console.log(`存款前WETH持仓: ${ethers.formatEther(balanceWETH)}\n`)




console.log("\n2. 调用desposit()函数，存入0.001 ETH")
// 发起交易
const tx = await contractWETH.deposit({value: ethers.parseEther("0.001")})
// 等待交易上链
await tx.wait()
console.log(`交易详情：`)
console.log(tx)
const balanceWETH_deposit = await contractWETH.balanceOf(address)
console.log(`存款后WETH持仓: ${ethers.formatEther(balanceWETH_deposit)}\n`)



console.log("\n3. 调用transfer()函数，给vitalik转账0.001 WETH")
// 发起交易
const tx2 = await contractWETH.transfer("vitalik.eth", ethers.parseEther("0.001"))
// 等待交易上链
await tx2.wait()
const balanceWETH_transfer = await contractWETH.balanceOf(address)
console.log(`转账后WETH持仓: ${ethers.formatEther(balanceWETH_transfer)}\n`)

