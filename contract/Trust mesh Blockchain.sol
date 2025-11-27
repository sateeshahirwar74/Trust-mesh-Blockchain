// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Project
 * @notice A simple Trust Mesh prototype where users register and gain trust score.
 */
contract Project {

    struct Node {
        bool registered;
        uint256 trustScore;
        address owner;
    }

    mapping(address => Node) private nodes;

    event NodeRegistered(address indexed node);
    event TrustAdded(address indexed node, uint256 amount);

    /**
     * @notice Register the sender as a node in the trust mesh.
     */
    function registerNode() external {
        require(!nodes[msg.sender].registered, "Already registered");

        nodes[msg.sender] = Node({
            registered: true,
            trustScore: 0,
            owner: msg.sender
        });

        emit NodeRegistered(msg.sender);
    }

    /**
     * @notice Add trust score to a registered node.
     * @param node Address of the node.
     * @param amount Trust points to add.
     */
    function addTrust(address node, uint256 amount) external {
        require(nodes[node].registered, "Node not registered");
        require(amount > 0, "Amount must be positive");

        nodes[node].trustScore += amount;
        emit TrustAdded(node, amount);
    }

    /**
     * @notice Get full node information.
     */
    function getNode(address node)
        external
        view
        returns (bool registered, uint256 trustScore, address owner)
    {
        Node memory n = nodes[node];
        return (n.registered, n.trustScore, n.owner);
    }
}

