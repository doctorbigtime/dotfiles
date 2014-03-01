" Vim syntax file
" Language:	C special highlighting
" Maintainer:	Sebastien F.
" Last Change:	2012/01/01

syn keyword cConstant MSG_NOSIGNAL MSG_DONTWAIT
syn keyword cConstant SIOCGIFADDR AF_INET PF_INET 
syn keyword cConstant SOCK_STREAM SOCK_DGRAM SOL_SOCKET 
syn keyword cConstant SO_REUSEADDR SO_RCVBUF SO_SNDBUF SO_BROADCAST SO_KEEPALIVE SO_ERROR
syn keyword cConstant IPPROTO_IP IPPROTO_TCP IPPROTO_UDP
syn keyword cConstant IP_MULTICAST_TTL IP_MULTICAST_LOOP IP_ADD_MEMBERSHIP IP_DROP_MEMBERSHIP
syn keyword cConstant INADDR_ANY INET_ADDRSTRLEN 
syn keyword cConstant EPOLLOUT EPOLLERR EPOLLIN EPOLLHUP EPOLL_CTL_MOD EPOLL_CTL_ADD EPOLL_CTL_RM
syn keyword cConstant F_SETFL F_GETFL O_NONBLOCK

hi def link cFunction Function

