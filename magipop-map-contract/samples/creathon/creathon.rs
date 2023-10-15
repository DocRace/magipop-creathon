use creathon::{
    account_info::{next_account_info, AccountInfo},
    entrypoint,
    entrypoint::ProgramResult,
    msg,
    program_error::ProgramError,
    pubkey::Pubkey,
    program_pack::Pack,
};

use byteorder::{ByteOrder, LittleEndian};

// Define the state of the Creathon
#[derive(Clone, Debug, Default, PartialEq)]
pub struct Creathon {
    pub is_initialized: bool,
    pub owner: Pubkey,
    // Add other fields as needed
}

// Implement packing and unpacking for the Creathon state
impl Pack for Creathon {
    const LEN: usize = 33; // 1 (is_initialized) + 32 (owner)

    fn unpack_from_slice(src: &[u8]) -> Result<Self, ProgramError> {
        let is_initialized = match src.get(0) {
            Some(&byte) => byte != 0,
            None => return Err(ProgramError::InvalidAccountData),
        };
        let owner = Pubkey::new(&src[1..33]);
        Ok(Creathon { is_initialized, owner })
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
            // Initialize Creathon
            let creathon_account = next_account_info(accounts_iter)?;
            let mut creathon_info = Creathon::unpack_unchecked(&creathon_account.data.borrow())?;
            if creathon_info.is_initialized {
                return Err(ProgramError::AccountAlreadyInitialized);
            }
            creathon_info.is_initialized = true;
            creathon_info.owner = *creathon_account.key;
            Creathon::pack(creathon_info, &mut creathon_account.data.borrow_mut())?;
            msg!("Initialized Creathon");
        },
        1 => {
            // Submit Work
            let creathon_account = next_account_info(accounts_iter)?;
            let creathon_info = Creathon::unpack_unchecked(&creathon_account.data.borrow())?;
            if !creathon_info.is_initialized {
                return Err(ProgramError::UninitializedAccount);
            }
            let user_account = next_account_info(accounts_iter)?;
            if *user_account.key != creathon_info.owner {
                return Err(ProgramError::InvalidAccountData);
            }
            msg!("Work Submitted by owner");
        },
        2 => {
            // Distribute Rewards
            let creathon_account = next_account_info(accounts_iter)?;
            let creathon_info = Creathon::unpack_unchecked(&creathon_account.data.borrow())?;
            if !creathon_info.is_initialized {
                return Err(ProgramError::UninitializedAccount);
            }
            let user_account = next_account_info(accounts_iter)?;
            if *user_account.key != creathon_info.owner {
                return Err(ProgramError::InvalidAccountData);
            }
            msg!("Rewards Distributed by owner");
        },
        _ => {
            return Err(ProgramError::InvalidInstructionData);
        }
    }

    Ok(())
}