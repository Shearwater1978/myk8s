$network=$args[0]

(Get-Content -Path D:\vmforjenkins\git\kubernetes\localenv\Vagrantfile -Raw) -replace 'changeme',$network | Set-Content -Path D:\vmforjenkins\git\kubernetes\localenv\Vagrantfile
