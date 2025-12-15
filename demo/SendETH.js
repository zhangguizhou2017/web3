import { ethers } from 'ethers';

const MY_INFURA_MAINNET_RPC = 'https://mainnet.infura.io/v3/4013d92584b14f69a0128110b7c76be4';
const MY_INFURA_SEPOLIA_RPC = 'https://sepolia.infura.io/v3/4013d92584b14f69a0128110b7c76be4';


const providerMainnet = new ethers.JsonRpcProvider(MY_INFURA_MAINNET_RPC); 
const providerSepolia = new ethers.JsonRpcProvider(MY_INFURA_SEPOLIA_RPC); 

const main = async () => {
    const wallet1 = ethers.Wallet.fromPhrase('admit pretty inhale seed quantum slim canyon sea gentle paper cram outer');
    const wallet1WithProvider = wallet1.connect(providerSepolia);
    const mnemonic = wallet1WithProvider.mnemonic // 获取助记词
    const address1 = await wallet1.getAddress();
    console.log(mnemonic.phrase, address1);
    const address2 = '0x99cFB7Dd7B7329DC55B4c238203855378Ae869c7';
    const tx = {
        to: address2,
        value: ethers.parseEther('0.001')
    }
    console.log(`\n5. 发送ETH（测试网）`);
    // i. 打印交易前余额
    console.log(`i. 发送前余额`)
    console.log(`钱包1: ${ethers.formatEther(await providerSepolia.getBalance(wallet1WithProvider))} ETH`)
    // iii. 发送交易，获得收据
    console.log(`\nii. 等待交易在区块链确认（需要几分钟）`)
    const receipt = await wallet1WithProvider.sendTransaction(tx)
    await receipt.wait() // 等待链上确认交易
    console.log(receipt) // 打印交易详情
    // iv. 打印交易后余额
    console.log(`\niii. 发送后余额`)
    console.log(`钱包1: ${ethers.formatEther(await providerSepolia.getBalance(wallet1WithProvider))} ETH`)
}

main();