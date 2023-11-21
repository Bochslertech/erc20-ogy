#!/bin/bash

# 1. 部署罐子, 查询罐子的以太坊地址
# export RUSTIC_USER_PAGE_END=1024
dfx deploy --network ic minter

# 2. 随便设置参数, 用以更新以太坊地址, 否则无法查询
ETHRPC_ID="ldbqd-4iaaa-aaaai-qpcwa-cai"
LEDGER_ID="jwcfb-hyaaa-aaaaj-aac4q-cai" # OGY 罐子
# dfx canister --network ic call minter set_ckicp_config "(record {
#     expiry_seconds = 18000: nat64;
#     max_response_bytes = 4000: nat64;
#     target_chain_ids = vec {1}: vec nat64;
#     ckicp_eth_erc20_address = \"0x50DE675A89bB4eEBFFdA4AcC37490D0e45469Ec6\";
#     eth_rpc_service_url = \"https://ethereum.publicnode.com\";
#     eth_rpc_canister_id = principal \"$ETHRPC_ID\";+
#     ledger_canister_id = principal \"$LEDGER_ID\";
#     ckicp_getlogs_topics = vec { \"0x1514ae047e94760894dc39d66b685a8ad09a294af33e3986f382ce6210e89adc\"; \"0xfe24e9930a618fda688a5b70e1dc6d04d22bd167d075d70a01f5b8df2bf73854\" } : vec text;
#     ckicp_fee = 200000 : nat64;
#     last_synced_block_number = 10_070_428 : nat64;
#     sync_interval_secs = 180 : nat64;
#     cycle_cost_of_eth_getlogs = 900000000 : nat;
#     cycle_cost_of_eth_blocknumber = 900000000 : nat;
#     debug_log_level = 3;
#     ecdsa_key_name = \"key_1\";
# })"
# dfx canister --network ic call minter update_ckicp_state
# dfx canister --network ic call minter get_tecdsa_signer_address_hex
# 0x88b830c911a6aa50d8d1a15f7b4839fe76fb4b00 这是跨链罐子的地址

# 3. 去测试网部署合约代码
# 0x494EB935Ff4437734f9B73E5A77b9AB3ae8075D0 这是部署的合约地址
# gas 2,655,193
# Base: 32.470178228 Gwei |Max: 32.747819579 Gwei |Max Priority: 1 Gwei
# 0.086951781311423747 ETH

# 4. 更新配置
# dfx canister --network ic call minter set_ckicp_config "(record {
#     expiry_seconds = 18000: nat64;
#     max_response_bytes = 4000: nat64;
#     target_chain_ids = vec {1}: vec nat64;
#     ckicp_eth_erc20_address = \"0x494EB935Ff4437734f9B73E5A77b9AB3ae8075D0\";
#     eth_rpc_service_url = \"https://ethereum.publicnode.com\";
#     eth_rpc_canister_id = principal \"$ETHRPC_ID\";
#     ledger_canister_id = principal \"$LEDGER_ID\";
#     ckicp_getlogs_topics = vec { \"0x1514ae047e94760894dc39d66b685a8ad09a294af33e3986f382ce6210e89adc\"; \"0xfe24e9930a618fda688a5b70e1dc6d04d22bd167d075d70a01f5b8df2bf73854\" } : vec text;
#     ckicp_fee = 200000 : nat64;
#     last_synced_block_number = 18617263 : nat64;
#     sync_interval_secs = 180 : nat64;
#     cycle_cost_of_eth_getlogs = 900000000 : nat;
#     cycle_cost_of_eth_blocknumber = 900000000 : nat;
#     debug_log_level = 3;
#     ecdsa_key_name = \"key_1\";
# })"

# 5. 查询自身的子账户用以充值
# dfx canister --network ic call minter get_funding_account
# ko6sb-zwe67-hhmjq-x4f77-vk2os-h5cc4-lv55n-gmw3k-dv2cz-gkwgg-bqe
# lwgbo-5aaaa-aaaai-qpcvq-cai-bp5d6za.1dc4f7ce762617e17ffaab4e91fa217175ef5a665b6a1d742c99563183020000

# 6. 充值
DEFAULT=$(dfx identity --network ic get-principal)
MINTER_ID=$(dfx canister --network ic id minter)
echo $MINTER_ID
# echo 'before charge'
# 298_800_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# 0
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
# dfx canister --network ic call $LEDGER_ID icrc1_transfer "(record { amount=200200000:nat; to=record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}}})"
# echo 'after charge'
# 98_400_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# 200_200_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"

# 7. 获取铸币签名
# echo 'before mint'
# 200_200_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
# 0
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# dfx canister --network ic call minter mint_ckicp "(vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}, 200000000:nat64, \"0x13b16794Cf687A468fa68832368ACa3D531154d6\")"
# echo 'after mint'
# 0
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\";subaccount=opt vec{29:nat8;196:nat8;247:nat8;206:nat8;118:nat8;38:nat8;23:nat8;225:nat8;127:nat8;250:nat8;171:nat8;78:nat8;145:nat8;250:nat8;33:nat8;113:nat8;117:nat8;239:nat8;90:nat8;102:nat8;91:nat8;106:nat8;29:nat8;116:nat8;44:nat8;153:nat8;86:nat8;49:nat8;131:nat8;2:nat8;0:nat8;0:nat8}})"
# 200_000_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# Ok = record {
#     to = "0x13b16794Cf687A468fa68832368ACa3D531154d6";
#     msgid = 159552093578004459177790481447785415544 : nat;
#     signature = "dfaa56e07ed0d791ab284a2020a572d4ffe734ab0a04951aacc330105eb5c5126c9aff8c8b9944c66c36cb9f7fc9e9856775aebd8450cd564ee8ce5f598003e31b";
#     expiry = 1700554584 : nat64;
#     amount = 200000000 : nat64;
# }

# 8. 在以太坊合约上调用铸币签名
# 注意去除下划线, 签名前面要加上 0x
# 103,940
# Base: 28.651613389 Gwei |Max: 28.899547789 Gwei |Max Priority: 1 Gwei
# 0.00300381899718866 ETH

# 9. 调用合约的 burn 方法返回 IC
# "0x1dc4f7ce762617e17ffaab4e91fa217175ef5a665b6a1d742c99563183020000" # ! 注意这是 principal 的 slice 的版本 调用 get_principal_slice_hex 可直接获得
# "0x0000000000000000000000000000000000000000000000000000000000000000"
# 42,131
# Base: 30.696105546 Gwei |Max: 31.177607086 Gwei |Max Priority: 1 Gwei
# 0.001313543764140266 ETH

# 10. 跨链罐释放 通过定时任务 或 主动触发接口
# 200_000_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# 98_400_000
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# dfx canister --network ic call minter process_block "(\"0xa114f8a0d6151227564908e3a369aa2315aca8cbd70c3afeb4f984e2e38e9657\")"
# dfx canister --network ic call minter process_block "(\"0x2cc051fcf96c3e3148881663afac6b56ce48a0b44542357f7d10507c5fa87905\")"
# dfx canister --network ic call minter view_debug_log "(record{})"
# 100_000_000
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
# 198_200_000
dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# safe 13mins
# finalized 21mins

# 11. 调用合约的 burnToAccountId 方法返回 IC
# "0x61caad265033c244e62978a3d24220d7e78214299042c629d796bb0f0bf6fc22"
# 42,131
# Base: 30.696105546 Gwei |Max: 31.177607086 Gwei |Max Priority: 1 Gwei
# 0.001313543764140266 ETH

# 12. 跨链罐释放 通过定时任务 或 主动触发接口
#
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$MINTER_ID\"})"
#
# dfx canister --network ic call $LEDGER_ID icrc1_balance_of "(record{owner=principal \"$DEFAULT\"})"
# dfx canister --network ic call minter process_block "(\"0x2072575b5d0c2e6d231b0d975009c39da6171e3aecf888d99101bea346bb472d\")"
# dfx canister --network ic call minter process_block "(\"0xaf9d225bdfa404183b086c1419829c5fa902a42830b8ebf8b0260b09e4be5fff\")"
