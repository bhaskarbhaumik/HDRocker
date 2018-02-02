#!/bin/bash

# Add Linux groups radmin & rusers
groupadd radmin
groupadd rusers

# Add Linux users radmin & ruser
useradd -c "R Administrator" -d /home/radmin -g radmin -m -p '$6$H4vLqDpp$yFhLdPdYstcNW9tkyofxCH1xyS.08AUkTrBoRfMO5OqjJv6Yig4LyldQaOUR/Cf5zkAnu4ep/l91.tPCyl6dR.' -s /bin/bash radmin
useradd -c "R User" -d /home/ruser -g rusers -G users,rusers -m -p '$6$H4vLqDpp$yFhLdPdYstcNW9tkyofxCH1xyS.08AUkTrBoRfMO5OqjJv6Yig4LyldQaOUR/Cf5zkAnu4ep/l91.tPCyl6dR.' -s /bin/bash ruser
# Reset root password
usermod -p '$6$H4vLqDpp$yFhLdPdYstcNW9tkyofxCH1xyS.08AUkTrBoRfMO5OqjJv6Yig4LyldQaOUR/Cf5zkAnu4ep/l91.tPCyl6dR.' root

# Give root access to radmin through sudo
echo "%radmin	ALL=(ALL)	NOPASSWD: ALL" >>/etc/sudoers

exit 0
