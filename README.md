# pos.loh

Agriculture POS System, made in 8086 Assembly

## Directions

### One-time Setup

#### Choice 1: If you DID NOT clone the repo into `C:\8086`

- Clone the repo appropriately
- Open the repo

- Double-click the `setup.bat` as administrator to create appropriate links. There should be no errors.
- One common error is because there is already a `loh.pos` folder inside the `C:\8086`. If so, unless you clicked `setup.bat` before, delete it.

#### Choice 2: If you clone the repo into `C:\8086`

- You're good to go, proceed to 'Usual operation'.

### Usual operation

- Open your DOSBox,  setup accordingly:

  ```bash
  MOUNT C: C:\8086
  cd C:
  cd POS.LOH
  ```

- Enter in DOSBox `make`, the program should automatically compile, link, and run the program

- Make all edits in the `.ASM` file, be careful not to edit other people's part unless with permission

### Committing and Pushing

- Open your GitHub client, check if all your modifications are there.
- Commit then push.
- No need to specifically copy here and there, because all the file are already in appropriate location.