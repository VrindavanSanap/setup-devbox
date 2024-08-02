cd ~
git clone https://github.com/VrindavanSanap/configuration.git
rm -rf ./configuration/.git
mv ./configuration/* .
for file in (N) *(.); do source "$file"; done
rm -rf ./configuration
