function [] = visualization(net, layer, data, plot_title)
res = vl_simplenn(net, data.images.data);
res = squeeze(res(layer).x);

tsne_res = tsne(res');
gscatter(tsne_res(:,1), tsne_res(:,2), data.images.labels);
title(plot_title);
end