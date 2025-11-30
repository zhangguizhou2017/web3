// SPDX-License-Identifier: MIT

pragma solidity ^0.8.21;

// ✅ 创建一个名为Voting的合约，包含以下功能：
// 一个mapping来存储候选人的得票数
// 一个vote函数，允许用户投票给某个候选人
// 一个getVotes函数，返回某个候选人的得票数
// 一个resetVotes函数，重置所有候选人的得票数
contract Voting {
    // 存储每个候选人得票数的映射
    mapping(address => uint256) private votes;
    // 存储所有候选人地址的数组
    address[] private candidates;
    // 记录地址是否已经是候选人
    mapping(address => bool) private isCandidate;

    // 投票事件，记录投票者和候选人
    event Voted(address indexed voter, address indexed candidate);
    // 重置票数事件
    event VotesReset(address indexed resetter);

    // 投票函数，允许用户给指定候选人投票
    function vote(address candidate) public {
        require(candidate != address(0), "Invalid candidate address");

        // 如果是新候选人，添加到候选人列表
        if (!isCandidate[candidate]) {
            candidates.push(candidate);
            isCandidate[candidate] = true;
        }

        votes[candidate]++;
        emit Voted(msg.sender, candidate);
    }

    // 获取指定候选人的得票数
    function getVotes(address candidate) public view returns (uint256) {
        return votes[candidate];
    }

    // 重置所有候选人的票数
    function resetVotes() public {
        for (uint256 i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
        emit VotesReset(msg.sender);
    }
}

// ✅ 反转字符串 (Reverse String)
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
contract StringReverser {
    function reverseString(string memory str) public pure returns(string memory) {
        // 将字符串转换为字节数组
        bytes memory strBytes = bytes(str);
        // 创建一个新的字节数组用于存储反转后的结果
        bytes memory result = new bytes(strBytes.length);

        // 从后往前遍历，将字符反转存入结果数组
        for(uint256 i = 0; i < strBytes.length; i++) {
            result[i] = strBytes[strBytes.length - 1 - i];
        }

        // 将字节数组转换回字符串
        return string(result);
    }
}

//  用 solidity 实现整数转罗马数字
contract RomanToInt {
    function romanToInt(uint256 number1) public pure returns(string memory) {
        // 检查输入范围，罗马数字只能表示 1-3999
        require(number1 > 0 && number1 < 4000, "Number must be between 1 and 3999");

        // 定义罗马数字对应的值（从大到小）
        uint256[13] memory values = [
            uint256(1000), 900, 500, 400, 100,
            90, 50, 40, 10, 9, 5, 4, 1
        ];

        // 定义罗马数字符号（对应上面的值）
        string[13] memory symbols = [
            "M", "CM", "D", "CD", "C",
            "XC", "L", "XL", "X", "IX", "V", "IV", "I"
        ];

        string memory result = "";
        uint256 num = number1;

        // 从最大的值开始遍历
        for (uint256 i = 0; i < 13; i++) {
            // 当前数字可以包含多少个当前罗马数字
            while (num >= values[i]) {
                result = string(abi.encodePacked(result, symbols[i]));
                num -= values[i];
            }
        }

        return result;
    }
}

//✅  用 solidity 实现罗马数字转数整数
contract IntToRoman {
    function intToRoman(string memory s) public pure returns(uint256) {
        // 将字符串转换为字节数组
        bytes memory romanBytes = bytes(s);
        uint256 result = 0;
        uint256 prevValue = 0;

        // 从右往左遍历罗马数字字符串
        for (uint256 i = romanBytes.length; i > 0; i--) {
            uint256 currentValue = getRomanValue(romanBytes[i - 1]);

            // 如果当前值小于前一个值，说明是减法规则（如 IV, IX）
            if (currentValue < prevValue) {
                result -= currentValue;
            } else {
                result += currentValue;
            }

            prevValue = currentValue;
        }

        return result;
    }

    // 辅助函数：获取单个罗马数字字符对应的整数值
    function getRomanValue(bytes1 char) private pure returns(uint256) {
        if (char == 'I') return 1;
        if (char == 'V') return 5;
        if (char == 'X') return 10;
        if (char == 'L') return 50;
        if (char == 'C') return 100;
        if (char == 'D') return 500;
        if (char == 'M') return 1000;
        return 0; // 无效字符返回0
    }
}


// 合并两个有序数组 (Merge Sorted Array)
// 题目描述：给定两个有序数组，将它们合并成一个有序数组
contract MergeSortedArray {
    function merge(uint256[] memory arr1, uint256[] memory arr2) public pure returns(uint256[] memory) {
        // 创建结果数组，长度为两个数组长度之和
        uint256[] memory result = new uint256[](arr1.length + arr2.length);

        uint256 i = 0; // arr1 的索引
        uint256 j = 0; // arr2 的索引
        uint256 k = 0; // result 的索引

        // 比较两个数组的元素，将较小的放入结果数组
        while (i < arr1.length && j < arr2.length) {
            if (arr1[i] <= arr2[j]) {
                result[k] = arr1[i];
                i++;
            } else {
                result[k] = arr2[j];
                j++;
            }
            k++;
        }

        // 将 arr1 中剩余的元素复制到结果数组
        while (i < arr1.length) {
            result[k] = arr1[i];
            i++;
            k++;
        }

        // 将 arr2 中剩余的元素复制到结果数组
        while (j < arr2.length) {
            result[k] = arr2[j];
            j++;
            k++;
        }

        return result;
    }
}


// 二分查找 (Binary Search)
// 题目描述：在有序数组中查找目标值，返回目标值的索引，如果不存在返回 -1
contract BinarySearch {
    function binarySearch(uint256[] memory arr, uint256 target) public pure returns(int256) {
        // 如果数组为空，直接返回 -1
        if (arr.length == 0) {
            return -1;
        }

        int256 left = 0;
        int256 right = int256(arr.length) - 1;

        // 当左指针小于等于右指针时继续查找
        while (left <= right) {
            // 计算中间位置，避免溢出
            int256 mid = left + (right - left) / 2;

            // 找到目标值，返回索引
            if (arr[uint256(mid)] == target) {
                return mid;
            }
            // 如果中间值小于目标值，在右半部分查找
            else if (arr[uint256(mid)] < target) {
                left = mid + 1;
            }
            // 如果中间值大于目标值，在左半部分查找
            else {
                right = mid - 1;
            }
        }

        // 没有找到目标值，返回 -1
        return -1;
    }
}

