#!/bin/bash

# 5. 查询自身的子账户用以充值
# dfx canister --network ic call minter get_funding_account
# ko6sb-zwe67-hhmjq-x4f77-vk2os-h5cc4-lv55n-gmw3k-dv2cz-gkwgg-bqe
# lwgbo-5aaaa-aaaai-qpcvq-cai-bp5d6za.1dc4f7ce762617e17ffaab4e91fa217175ef5a665b6a1d742c99563183020000

# 6. 充值
DEFAULT=$(dfx identity --network ic get-principal)
MINTER_ID=$(dfx canister --network ic id minter)
echo $MINTER_ID
# echo 'before charge'
# 200_198_200_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# 0
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
# dfx canister --network ic call $LEDGER_ID icrc1_transfer "(record { amount=200000200000:nat; to=record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}}})"
# echo 'after charge'
# 98_400_000
# 197_800_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
#     200_200_000
# 200_000_200_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"

# 7. 获取铸币签名
# echo 'before mint'
#     200_200_000
# 200_000_200_000
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
# 100_000_000
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# ! 要注意替换目标地址啊！！！
TARGET_ADDRESS="0x13b16794Cf687A468fa68832368ACa3D531154d6"
TARGET_AMOUNT="200_000_000_000"
dfx canister --network ic call minter mint_ckicp "(vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}, $TARGET_AMOUNT:nat64, \"$TARGET_ADDRESS\")"
# echo 'after mint'
# 0
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
#     100_000_000
# 200_100_000_000
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# Ok = record {
#     to = "0x13b16794Cf687A468fa68832368ACa3D531154d6";
#     msgid = 240523405351598715849193131737353256198 : nat;
#     signature = "d4e4b6f25c6631c85bd11058b88f530ac8b5afed0c6853a7e584d4a2af1e69c252e9b20750b922949293c4597e1e19ec2f87cd42273e7252a6b17f2b065cc1fc1b";
#     expiry = 1700566553 : nat64;
#     amount = 200000000000 : nat64;
# }

# 8. 在以太坊合约上调用铸币签名
# 注意去除下划线, 签名前面要加上 0x
# 103,940
# Base: 28.651613389 Gwei |Max: 28.899547789 Gwei |Max Priority: 1 Gwei
# 0.00300381899718866 ETH
