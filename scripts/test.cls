poolBotWorkshopFinder.WorkshopSearchInput input = new poolBotWorkshopFinder.WorkshopSearchInput();

input.SearchPhrase = 'Adoption';

list<poolBotWorkshopFinder.WorkshopSearchInput> inputs = new list<poolBotWorkshopFinder.WorkshopSearchInput>();
inputs.add(input);

system.debug(poolBotWorkshopFinder.getWorkshops(inputs));