# Configuration
maximum contract size limit is 24KB

## framework: brownie
documentation: https://eth-brownie.readthedocs.io/en/latest

### install brownie
#### option 1:
    > pip3 install eth-brownie

#### option 2:
Install pipx:

    > python3 -m pip install --user pipx
    > python3 -m pipx ensurepath

Install brownie:

    > pipx install eth-brownie


## install ganache
    > sudo npm install -g ganache-cli

# Install Slither or optionally install it inside a python virtual env
    > pip3 install slither-analyzer

Then install VS Code plug-in for slither

@ style imports are not supported with Slither. Make sure to change the import paths to explicitly list the node_modules folder.

 Append 'node_modules/' before each import statement such as: 
    import "@openzeppelin/..."  -> import "node_modules/@openzeppelin/..."

# Python Packages
It's recommended to install the following Python packages to maintain
well formatted, clean code.
## Black
Black is a PEP8 compliant opinionated code formatter.

To install:

    > pip3 install black

To run:

    > black <python_script>.py

## Autoflake
Autoflake removes unused imports and unused variables. it makes use of pyflakes.

to install:

    > pip3 install autoflake

To run:

    > autoflake --in-place --remove-all-unused-imports --remove-unused-variables <python_script>.py

## Create and View Contract Call/Inheritance Path and Control Flow Graphs
Append 'node_modules/' before each import statement such as: 

    import "@openzeppelin/..."  -> import "node_modules/@openzeppelin/..."

# Compiling
To compile the solidity smart contracts, run the following command:

    > brownie compile

To compile using solc, specify the import path remapping on the command-line:

    > solc @openzeppelin/=$(pwd)/node_modules/@openzeppelin/ contracts/*.sol

# Testing
To execute the unit tests defined in the tests/ folder, run the following command:

    > brownie test -s --update --interactive

    -s: prints out to the console output from print()
    --update: only runs the new test cases
    --interactive: breaks into the console. this allows debugging when a failed assert occurs

When calling a Solidity function, the returned result is the txn instead of the value. To get the value, add '.call()' to the end of the function name.

To verify your test coverage, use the following flag:

    > brownie test --coverage

# Gas Usage
To estimate gas usage, run the following command:

    > brownie test --gas

 To generate an account:

    > brownie accounts generate <ACCOUNT_NAME>

    The generated key and address is stored in the folder 
    ~/.brownie/accounts/<AACOUNT_NAME>.json

To export account into a keystore file:

    > brownie accounts export <ACCOUNT_NAME> <KEYSTORE_FILENAME>

To import account from a keystore file:

    > brownie accounts import <ACCOUNT_NAME> <KEYSTORE_FILENAME>

To run a script in the py_scripts folder:

    > brownie run <SCRIPT_NAME> --network <ropsten | rinkeby | main>

# Deploy to testnet or mainnet
set the following environment variables:

    > export WEB3_INFURA_PROJECT_ID=<infura_key>
    > export ETHERSCAN_TOKEN=<etherscan_key>

run the deployment script in scripts:

    > brownie run deploy.py
