c Matthew Anderson
c interface to nekbone driver
c notice that nekbone was written with implicits
c variables starting with i -- n are integers, all others are reals
c-----------------------------------------------------------------------
      subroutine nekproxy(hpx_bti,hpx_mype,hpx_numberpe)
      use, intrinsic :: iso_c_binding, only : c_ptr

      integer hpx_mype,hpx_numberpe
      TYPE(C_PTR), INTENT(IN), VALUE :: hpx_bti

ccccccccccccccccccccccccccccccccccc
c SIZE
c     These numbers come from example1 
      parameter (ldim=3)
      parameter (lx1=10,ly1=lx1,lz1=lx1)
      parameter (lxd=10,lyd=lxd,lzd=1)

      parameter (lp = 2)
      parameter (lelt=1)

      parameter (lelg=lelt*lp)
      parameter (lelx=lelg,lely=1,lelz=1)

      parameter (ldimt=1,ldimt1=ldimt+1)

c      common /dimn/ nelx,nely,nelz,nelt,nelg
c     $            , nx1,ny1,nz1,ndim,nfield,nid
      integer nelx,nely,nelz,nelt,nelg
     &            , nx1,ny1,nz1,ndim,nfield,nid

ccccccccccccccccccccccccccccccccccc
c DXYZ
      real dxm1(lx1,lx1),  dxtm1(lx1,lx1)
ccccccccccccccccccccccccccccccccccc
c INPUT
      real xc(8,lelt),yc(8,lelt),zc(8,lelt),
     &       bc(5,6,lelt,0:ldimt1)
      character*1     ccurve(12,lelt)
      character*3     cbc(6,lelt,0:ldimt1)
ccccccccccccccccccccccccccccccccccc
c MASS
      real bm1   (lx1,ly1,lz1,lelt)
     &      ,binvm1(lx1,ly1,lz1,lelt)
     &      ,volvm1
ccccccccccccccccccccccccccccccccccc
c PARALLEL
      integer node,pid,np,nullpid,node0
c     Maximum number of elements (limited to 2**31/12, at least
c      for now)
      parameter(nelgt_max = 178956970)
      integer nelgf(0:ldimt1)
     &              ,lglel(lelt)
     &              ,gllel(lelg)
     &              ,gllnid(lelg)
     &              ,nelgv,nelgt

      integer*8      nvtot

      logical ifgprnt
      integer wdsize,isize,lsize,csize
      logical ifdblas
C
C     crystal-router, gather-scatter, and xxt handles (xxt=csr grid
C     solve)
C
      integer cr_h, gsh, gsh_fld(0:ldimt1), xxth(ldimt1)
ccccccccccccccccccccccccccccccccccc
c WZ
c     Gauss-Labotto and Gauss points
      real zgm1(lx1,3)

c     Weights
      real wxm1(lx1), wym1(ly1), wzm1(lz1), w3m1(lx1,ly1,lz1)      
ccccccccccccccccccccccccccccccccccc
c nekmpi
      integer nid_,np_,nekcomm,nekgroup,nekreal

c     local variables
      parameter (lxyz = lx1*ly1*lz1)
      parameter (lt=lxyz*lelt)

      real ah(lx1*lx1),bh(lx1),ch(lx1*lx1),dh(lx1*lx1)
     $    ,zpts(2*lx1),wght(2*lx1)

      real x(lt),f(lt),r(lt),w(lt),p(lt),z(lt),c(lt)
      real g(6,lt)      

      call iniproc(hpx_bti,hpx_mype,hpx_numberpe,
     &   nid_,np_,nekcomm,nekgroup,nekreal,
c  SIZE
     &     nelx,nely,nelz,nelt,nelg,
     &     nx1,ny1,nz1,ndim,nfield,nid,
c  PARALLEL
     &     node,pid,np,nullpid,node0,
     &     nelgf,lglel,gllel,gllnid,
     &     nelgv,nelgt,nvtot,ifgprnt,
     &     wdsize,isize,lsize,csize,ifdblas,
     &     cr_h,gsh,gsh_fld,xxth)

      print*,' TEST I am ',hpx_mype

      end subroutine nekproxy
