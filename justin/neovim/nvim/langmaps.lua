local langmaps = {
    ["QWERTY"] = '',
    ["COLMAKDH"] = [[qq,ww,fe,pr,bt,jy,lu,ui,yo,\\;p,aa,rs,sd,tf,gg,mh,nj,ek,il,o\\;,zz,xx,cc,dv,vb,kn,hm,QQ,WW,FE,PR,BT,JY,LU,UI,YO,:P,AA,RS,SD,TF,GG,MH,NJ,EK,IL,O:,ZZ,XX,CC,DV,VB,KN,HM]],
}

vim.keymap.set("n", "<leader><leader><A-q>", function()
    print("langmap set")
    vim.cmd [[source ~/.config/nvim/lua/langmaps.lua]]
end)
vim.cmd([[set langmap=]] .. langmaps[LANGMAP_SETTING])
