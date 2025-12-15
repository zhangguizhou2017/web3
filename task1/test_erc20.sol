function transfer(address to, uint256 amount) public returns (bool) {
    // 检查接受地址
    require(to != address(0), 'Cannot transfer to zero address')
    // 检查余额
    require(balances[msg.sender] >= amount, 'Insufficient balance')
    // 更新余额
    balances[msg.sender] -= amount;
    balances[to] += amount;
    // 触发事件
    emit Transfer(msg.sender, to, amount);
    // 返回true
    return true;
}

function approve(address spender, uint256 amount) public returns (bool) {
    // 检查被授权人地址
    require(spender != address(0), 'Invalid spender address')
    // 设置授权额度
    allowances[msg.sender][spender] = amount;
    // 触发授权事件
    emit Approval(msg.sender, spender, amount);
    return true;
}

function transferFrom(address from, address to, uint256 amount) public returns (bool) {
    // 检查地址有效性
    require(to != address(0), 'Cannot transfer to zero address')
    require(from != address(0), 'Cannot transfer from zero address')
    // 检查余额
    require(balances[from] >= amount, 'Insufficient balance')
    // 检查授权额度
    require(allowances[from][msg.sender] >= amount, 'Insufficient allowance')
    // 更新余额
    balances[from] -= amount;
    balances[to] += amount;
    // 更新授权额度
    allowances[from][msg.sender] -= amount;
    // 触发转账事件
    emit Transfer(from, to, amount);
    // 返回true
    return true;
}

contract DerivedContract is BaseContract {
    constructor(string memory _name, uint _value) 
        BaseContract(_name, _value) // 调用父合约的构造函数
    {
        // 子合约的构造函数体可以留空或添加其他逻辑
    }
}

calldatacopy(t, f, s) 将calldata输入数据 从位置f开始复制s字节到men（内存）的位置t。
// 调用合约a 的地址，输入为men[in..(in + insize)], 输出为men[out..(out + outsize)], 提供g wei 的以太坊gas，
// 这个操作码在错误时返回0，在成功是返回1
delegatecall(g, a, in, insize, out, outsize)
// 将returndata(输出数据)从位置f开始复制s字节到men的位置
returndatacopy(t, f, s);
return (p, s) // 终止函数执行，返回数据men[p..(p+s)]
revert (p, s) // 终止函数执行，回滚状态，返回数据men[p..(p+s)]

fallback() external payable {
    address _implementation = implementation;
    assembly {
        
    }
}