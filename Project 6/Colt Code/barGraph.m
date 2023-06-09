function barGraph(graphData,x_labels,y_label)
%barGraph Wrapper function for bar graphs for project 6
%xlabels = categorical({'01 City Block','01 Euclidian','02 City Block','02 Euclidian'});

b = bar(x_labels,graphData);
ylabel(y_label);
legend("1","3","5","11");

% data at top of bars
for i = 1:length(b);
    xtips1 = b(i).XEndPoints;
    ytips1 = b(i).YEndPoints;
    labels1 = string(b(i).YData);
    text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
end

end