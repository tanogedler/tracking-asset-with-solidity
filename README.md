### Smart contract for supply chain



## Preparation of the environment:

The first thing was to prepare the development environment. For this we installed the development environment for Ethereum called Truffle and a test blockchain called Ganache.

1.  install Truffle:

```
npm install -g truffle
```

2.  initialize the project with Truffle you must do the following:

```
mkdir tracking-asset-with-solidity && cd tracking-asset-with-solidity
init truffle
```

3. Save the contract traceability.sol in the directory contracts

4.Compile the contract
```
truffle compile
```

4. Deploy the contract: 
```
truffle migrate
```
