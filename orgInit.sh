sfdx force:org:create -f config/project-scratch-def.json -d 30 -s
sfdx force:source:push
sfdx force:user:permset:assign -n OrgPoolPerms
sfdx force:data:tree:import -p data/Org_Pool__c-Temporary_Pool__c-plan.json
sfdx force:user:password:generate
sfdx force:org:open
