use creathon_cNFT::{
    account_info::{next_account_info, AccountInfo},
    entrypoint,
    entrypoint::ProgramResult,
    msg,
    program_error::ProgramError,
    pubkey::Pubkey,
    program_pack::Pack,
};

use byteorder::{ByteOrder, LittleEndian};

// Define the state of the NFT
#[derive(Clone, Debug, Default, PartialEq)]
pub struct CompressedNFT {
    pub is_initialized: bool,
    pub owner: Pubkey,
    // Add other fields as needed
}

// Implement packing and unpacking for the NFT state
impl Pack for CompressedNFT {
    const LEN: usize = 33; // 1 (is_initialized) + 32 (owner)

    fn unpack_from_slice(src: &[u8]) -> Result<Self, ProgramError> {
        let is_initialized = match src.get(0) {
            Some(&byte) => byte != 0,
            None => return Err(ProgramError::InvalidAccountData),
        };
        let owner = Pubkey::new(&src[1..33]);
        Ok(CompressedNFT { is_initialized, owner })
    }

    fn pack_into_slice(&self, dst: &mut [u8]) {
        dst[0] = if self.is_initialized { 1 } else { 0 };
        dst[1..33].copy_from_slice(self.owner.as_ref());
    }
}

entrypoint!(process_instruction);

pub fn process_instruction(
    program_id: &Pubkey,
    accounts: &[AccountInfo],
    instruction_data: &[u8],
) -> ProgramResult {
    let accounts_iter = &mut accounts.iter();
    let command = instruction_data[0];
    
    match command {
        0 => {
            // Initialize NFT
            let nft_account = next_account_info(accounts_iter)?;
            let mut nft_info = CompressedNFT::unpack_unchecked(&nft_account.data.borrow())?;
            if nft_info.is_initialized {
                return Err(ProgramError::AccountAlreadyInitialized);
            }
            nft_info.is_initialized = true;
            nft_info.owner = *nft_account.key;
            CompressedNFT::pack(nft_info, &mut nft_account.data.borrow_mut())?;
            msg!("Initialized NFT");
        },
        1 => {
            // Transfer NFT
            let nft_account = next_account_info(accounts_iter)?;
            let new_owner_account = next_account_info(accounts_iter)?;
            let mut nft_info = CompressedNFT::unpack_unchecked(&nft_account.data.borrow())?;
            if !nft_info.is_initialized {
                return Err(ProgramError::UninitializedAccount);
            }
            nft_info.owner = *new_owner_account.key;
            CompressedNFT::pack(nft_info, &mut nft_account.data.borrow_mut())?;
            msg!("NFT transferred to new owner");
        },
        2 => {
            // Stake NFT
            let nft_account = next_account_info(accounts_iter)?;
            let nft_info = CompressedNFT::unpack_unchecked(&nft_account.data.borrow())?;

            // check if the NFT is initialized
            if !nft_info.is_initialized {
                return Err(ProgramError::UninitializedAccount);
            }

            // check if the account staking the NFT is the owner of the NFT
            let user_account = next_account_info(accounts_iter)?;
            if *user_account.key != nft_info.owner {
                return Err(ProgramError::InvalidAccountData);
            }

            // perform the staking operation, this could be implementing a voting mechanism
            // or any other business logic as per your needs.
            msg!("NFT staked by owner");

            // update the NFT state if needed
            // CompressedNFT::pack(nft_info, &mut nft_account.data.borrow_mut())?;
        },
        _ => {
            return Err(ProgramError::InvalidInstructionData);
        }
    }

    Ok(())
}
