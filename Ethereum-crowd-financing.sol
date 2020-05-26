pragma solidity >=0.6.0;

contract CrowdDemo{
    
    // 创建投资人结构体
    struct Funder{
        address addr;  // 投资者地址
        uint amount;   // 投资金额
    }
    
    // 众筹的产品
    struct Product{
        address payable addr;  // 如果众筹成功,则金额会转到当前地址
        uint goal;   // 预期众筹的目标
        uint amount;   // 实际众筹的目标
        uint funderNum;   // 投资者的人数
        // 创建产品和投资人的关系
        mapping(uint => Funder) funders;
    }
    
    // 平台发布众筹产品
    Product[] public products;
    
    // 发布待众筹的商品信息
    function candidate(address payable addr,uint goal) public returns (uint){
        products.push(Product(addr,goal*10**18,0,0));
        return products.length;
    }
    
    // 编写函数实现众筹功能
    function vote(uint index) public payable{
        // 通过索引获取要众筹的产品
        Product storage p = products[index];   // a = b
        p.funders[p.funderNum++]= Funder({addr:msg.sender,amount:msg.value});
        // 把众筹的金额追加到amount中
        p.amount += msg.value;
    }
    
    // 检查某个产品是否众筹成功
    function check(uint index) public payable returns(bool){
        Product storage p = products[index];
        // 当前众筹金额是否大于设置金额
        if(p.amount < p.goal){
            return false;
        }
        // 众筹成功,金额转给产品对应的地址
        uint amount = p.amount;
        p.addr.transfer(amount);  // amount交给transfer函数的调用者
        p.amount = 0;
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
