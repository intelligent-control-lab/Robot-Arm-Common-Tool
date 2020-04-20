function v = FK(v, M)

v=M(1:3,1:3)*v'+M(1:3,4);