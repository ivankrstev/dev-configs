# Mount a Shared NTFS Partition Between Windows and Linux

This guide explains how to create and mount a shared NTFS partition that can be accessed from both Windows and Linux. It also includes optional steps for mounting the main Windows filesystem from Linux.

## 1. Disable Windows Fast Startup and Hibernation

Before mounting Windows NTFS partitions from Linux, disable Fast Startup and hibernation in Windows.

Open Command Prompt or PowerShell as Administrator and run:

```powershell
powercfg /h off
```

Also make sure **Fast Startup** is disabled:

1. Open **Control Panel**
2. Go to **Power Options**
3. Select **Choose what the power buttons do**
4. Click **Change settings that are currently unavailable**
5. Uncheck **Turn on fast startup**
6. Save changes

This prevents Windows from leaving NTFS partitions in a hibernated or unsafe state.

## 2. Create a Shared NTFS Partition in Windows

Use **Disk Management** in Windows to create a new NTFS volume.

This partition will be used as the shared drive between Windows and Linux.

## 3. Install NTFS Support on Arch Linux

Install `ntfs-3g`:

```bash
sudo pacman -S ntfs-3g
```

## 4. Identify the Windows and Shared Partitions

List available disks and partitions:

```bash
lsblk
```

Look for the relevant NTFS partitions and identify the shared/windows partitions.

Example devices:

```text
/dev/sdXN   Windows system partition
/dev/sdYM   Shared NTFS partition
```

or

```text
nvme1n1p1   Windows system partition
nvme1n1p2   Shared NTFS partition
```

Replace these with the actual partition names from your system.

## 5. Create Mount Points

Create directories where the partitions will be mounted:

```bash
sudo mkdir -p /mnt/windows
sudo mkdir -p /mnt/shared
```

## 6. Mount the Partitions Manually

Mount the main Windows filesystem:

```bash
sudo mount -t ntfs-3g /dev/sdXN /mnt/windows
or
sudo mount -t ntfs-3g /dev/nvme1n1p1 /mnt/windows
```

Mount the shared partition:

```bash
sudo mount -t ntfs-3g /dev/sdYM /mnt/shared
or
sudo mount -t ntfs-3g /dev/nvme1n1p2 /mnt/shared
```

> Note: If the Windows partition uses BitLocker, make sure BitLocker is fully disabled before mounting it directly from Linux.

## 7. Configure Automatic Mounting on Boot

### 7.1 Find Partition UUIDs

Use `blkid` to find the UUIDs:

```bash
sudo blkid
```

Use the value labeled `UUID`, not `PARTUUID`.

Example:

```text
/dev/sdYM: UUID="1234ABCD5678EFGH" TYPE="ntfs"
```

Or use: `lsblk -f`

### 7.2 Find Your User ID and Group ID

Run:

```bash
id -u
id -g
```

For a typical single-user Linux system, both values are often `1000`.

If the values are different, replace `uid=1000` and `gid=1000` with the values returned by `id -u` and `id -g`.

### 7.3 Edit `/etc/fstab`

Open `/etc/fstab`:

```bash
sudo nano /etc/fstab
```

Add an entry at end for the shared NTFS partition:

```fstab
UUID=shared_uuid /mnt/shared ntfs-3g defaults,uid=1000,gid=1000,dmask=027,fmask=137,nofail 0 0
```

Replace `shared_uuid` with the real UUID from `blkid`.

Example:

```fstab
UUID=1234ABCD5678EFGH /mnt/shared ntfs-3g defaults,uid=1000,gid=1000,dmask=027,fmask=137,nofail 0 0
```

Do the same for the Windows partition.

## 8. Test the Configuration

Before rebooting, test the `/etc/fstab` entry:

```bash
sudo mount -a
```

If there are no errors, verify the mount:

```bash
lsblk
df -h
```

The shared partition should now mount automatically at:

```text
/mnt/shared
```
